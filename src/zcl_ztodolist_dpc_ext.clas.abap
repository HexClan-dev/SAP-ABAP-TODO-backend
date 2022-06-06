class ZCL_ZTODOLIST_DPC_EXT definition
  public
  inheriting from ZCL_ZTODOLIST_DPC
  create public .

public section.

  constants GC_TODO_STATUS_DONE type ZTODO-STATUS value 2 ##NO_TEXT.
  constants GC_TODO_STATUS_OPEN type ZTODO-STATUS value 1 ##NO_TEXT.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.

  methods TODOSET_CREATE_ENTITY
    redefinition .
  methods TODOSET_DELETE_ENTITY
    redefinition .
  PRIVATE SECTION.
    METHODS _changestatus
      IMPORTING
        !iv_action_name TYPE string
        !it_parameter   TYPE /iwbep/t_mgw_name_value_pair
      EXPORTING
        !er_data        TYPE REF TO data.

    METHODS _getlastid
      IMPORTING
        !iv_action_name TYPE string
        !it_parameter   TYPE /iwbep/t_mgw_name_value_pair
      EXPORTING
        !er_data        TYPE REF TO data.

ENDCLASS.



CLASS ZCL_ZTODOLIST_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

    IF iv_action_name = 'ChangeStatus'. " Check what action is being requested
      me->_changestatus(
        EXPORTING
          iv_action_name = iv_action_name
          it_parameter   = it_parameter
        IMPORTING
          er_data        = er_data
      ).

    ELSEIF iv_action_name = 'GetLastId'.
      me->_getlastid(
        EXPORTING
          iv_action_name = iv_action_name
          it_parameter   = it_parameter
        IMPORTING
          er_data        = er_data
      ).

    ENDIF.

  ENDMETHOD.


  METHOD todoset_create_entity.

    DATA: ls_todo LIKE er_entity.
    io_data_provider->read_entry_data( IMPORTING es_data = ls_todo ).


    INSERT INTO ztodo VALUES ls_todo.

    IF sy-subrc EQ 0.
      er_entity = ls_todo.
    ENDIF.

  ENDMETHOD.


  METHOD todoset_delete_entity.

    DATA: lt_keys    TYPE /iwbep/t_mgw_tech_pairs,
          ls_key     TYPE /iwbep/s_mgw_tech_pair,
          lv_todo_id TYPE ztodo-id.

    lt_keys = io_tech_request_context->get_keys( ).

    READ TABLE lt_keys WITH KEY name = 'ID' INTO ls_key.

    IF sy-subrc = 0.
      lv_todo_id = ls_key-value.
      DELETE FROM ztodo WHERE id = lv_todo_id.

      IF sy-subrc <> 0.
        RAISE EXCEPTION NEW /iwbep/cx_mgw_busi_exception( ).
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD _changestatus.

    DATA: ls_parameter   TYPE /iwbep/s_mgw_name_value_pair,
          lv_todo_id     TYPE ztodo-id,
          lv_todo_status TYPE ztodo-status.

    IF it_parameter IS NOT INITIAL.

      READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'Id'.
      IF sy-subrc = 0.
        lv_todo_id = ls_parameter-value.
      ENDIF.

      SELECT SINGLE * FROM ztodo INTO @DATA(ls_todo) WHERE id = @lv_todo_id.

      IF sy-subrc = 0.

        lv_todo_status = COND #( WHEN ls_todo-status = gc_todo_status_done THEN gc_todo_status_open
                                 WHEN ls_todo-status = gc_todo_status_open THEN gc_todo_status_done ).

        UPDATE ztodo SET status = lv_todo_status WHERE id = lv_todo_id.

        IF sy-subrc = 0.

          ls_todo-status = lv_todo_status.
        ENDIF.

      ENDIF.

      " Call method copy_data_to_ref and export entity set data
      copy_data_to_ref( EXPORTING is_data = ls_todo
              CHANGING cr_data = er_data ).

    ENDIF.

  ENDMETHOD.


  METHOD _getlastid.

    DATA: lv_todo_id     TYPE ztodo-id.
    DATA: ls_todo TYPE ztodo.

    SELECT MAX( id )  FROM ztodo INTO @lv_todo_id.

    IF sy-subrc = 0.

    ls_todo-id = lv_todo_id.
      " Call method copy_data_to_ref and export entity set data
      copy_data_to_ref( EXPORTING is_data = ls_todo
              CHANGING cr_data = er_data ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
