class ZCL_ZTODO_MPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_MODEL_PROV
  create public .

public section.

  types:
     TS_TODO type ZITODO .
  types:
     TT_TODO type standard table of TS_TODO .

  methods /IWBEP/IF_V4_MP_BASIC~DEFINE
    redefinition .
protected section.
private section.

  methods DEFINE_TODO
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
ENDCLASS.



CLASS ZCL_ZTODO_MPC IMPLEMENTATION.


  method /IWBEP/IF_V4_MP_BASIC~DEFINE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 26.05.2022 05:34:45 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTODO_MPC_EXT
*&-----------------------------------------------------------------------------------------------*
  define_todo( io_model ).
  endmethod.


  method DEFINE_TODO.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 26.05.2022 05:34:45 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTODO_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lv_todo  TYPE zitodo.
***********************************************************************************************************************************
*   ENTITY - TODO
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type_by_struct( iv_entity_type_name = 'TODO' is_structure = lv_todo
                                                          iv_add_conv_to_prim_props = abap_true ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'TODO' ).                    "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ID' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Id' ).                         "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int32' ).        "#EC NOTEXT
 lo_property->set_is_key( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'TITLE' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Title' ).                      "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '50' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'DESCRIPTION' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Description' ).                "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '200' ).      "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ENDTIME' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Endtime' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'TimeOfDay' ).    "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ENDDATE' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Enddate' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Date' ).         "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'TODOSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'TODOSet' ).                  "#EC NOTEXT
  endmethod.
ENDCLASS.
