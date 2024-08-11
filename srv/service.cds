namespace shashank;

using shank as db from '../db/data-model';
using {managed} from '@sap/cds/common';

service CatalogService {
     entity BusinessPartners as projection on db.bp;
     entity address          as projection on db.ad;

     entity combo  @( cds.redirection.target: false ) as
          projection on db.bp{
               CLIENT,
               NODE_KEY,
               BP_ROLE,
               EMAIL_ADDRESS,
               PHONE_NUMBER,
               FAX_NUMBER,
               WEB_ADDRESS,
               ADDRESS_GUID,
               BP_ID,
               COMPANY_NAME,
               LEGAL_FORM,
               APPROVAL_STATUS,
               ADDRESS_GUID.COUNTRY,
               ADDRESS_GUID.CITY,
               ADDRESS_GUID.LATITUDE,
               ADDRESS_GUID.LONGITUDE
          };

     entity purchaseord  as projection on db.po;

     entity purchaseorditem  @ ( cds.redirection.target: false ) as projection on db.po.po_i;

     entity posum  @ ( cds.redirection.target: false )as projection on db.Thai;

}
