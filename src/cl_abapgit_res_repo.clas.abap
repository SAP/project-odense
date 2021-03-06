CLASS cl_abapgit_res_repo DEFINITION
  PUBLIC
  INHERITING FROM cl_adt_rest_resource
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS delete REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS cl_abapgit_res_repo IMPLEMENTATION.


  METHOD delete.

    DATA lv_repo_key TYPE if_abapgit_persistence=>ty_value.

    request->get_uri_attribute( EXPORTING
                                  name = 'key'
                                  mandatory = abap_true
                                IMPORTING
                                  value = lv_repo_key ).

    TRY.
        DATA(lo_repo) = cl_abapgit_repo_srv=>get_instance( )->get( lv_repo_key ).

        cl_abapgit_repo_srv=>get_instance( )->delete( lo_repo ).
        COMMIT WORK.

        response->set_status( cl_rest_status_code=>gc_success_ok ).

      CATCH cx_abapgit_exception INTO DATA(lx_exception).
        cx_adt_rest_abapgit=>raise_with_error( ix_error       = lx_exception
                                               iv_http_status = cl_rest_status_code=>gc_client_error_not_found ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
