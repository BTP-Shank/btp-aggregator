namespace shank;

entity bp {

    key NODE_KEY        : String(100);
        CLIENT          : String(3);
        BP_ROLE         : String(15);
        EMAIL_ADDRESS   : String(50);
        PHONE_NUMBER    : String(20);
        FAX_NUMBER      : String(30);
        WEB_ADDRESS     : String(30);
        BP_ID           : String(100);
        COMPANY_NAME    : String(100);
        LEGAL_FORM      : String(30);
        APPROVAL_STATUS : String(2);
        ADDRESS_GUID    : Association to ad;

}

entity ad {

    key NODE_KEY        : String(100);
        CLIENT          : String(3);
        CITY            : String(100);
        POSTAL_CODE     : String(100);
        STREET          : String(100);
        BUILDING        : String(100);
        COUNTRY         : String(100);
        ADDRESS_TYPE    : String(100);
        VAL_START_DATE  : String(100);
        VAL_END_DATE    : String(100);
        LATITUDE        : String(100);
        LONGITUDE       : String(100);
        businesspartner : Association to one bp
                              on businesspartner.ADDRESS_GUID = $self;
}

entity po.po_i {
        CLIENT        : String(3);
        key NODE_KEY      : String(100);
        PARENT_KEY    : Association to po;
        PO_ITEM_POS   : String(10);
        PRODUCT_GUID  : String(100);
        NOTE_GUID     : String(100);
        CURRENCY_CODE : String(100);
        GROSS_AMOUNT  : String(100);
        NET_AMOUNT    : String(50);
        TAX_AMOUNT    : String(50);

}

entity po {
        CLIENT           : String(3);
    key NODE_KEY         : String(60);
        PO_ID            : String(20);
        CREATED_BY       : String(100);
        CREATED_AT       : String(100);
        CHANGED_BY       : String(100);
        CHANGED_AT       : String(100);
        NOTE_GUID        : String(100);
        PARTNER_GUID     : String(100);
        CURRENCY_CODE    : String(100);
        GROSS_AMOUNT     : String(50);
        NET_AMOUNT       : String(50);
        TAX_AMOUNT       : String(50);
        LIFECYCLE_STATUS : String(10);
        APPROVAL_STATUS  : String(10);
        CONFIRM_STATUS   : String(10);
        ORDERING_STATUS  : String(10);
        INVOICING_STATUS : String(10);
        OVERALL_STATUS   : String(10);
        items            : Composition of many po.po_i
                               on items.PARENT_KEY = $self
}

// define view BusinessPartners as
//     select from bp {
//         CLIENT,
//         NODE_KEY,
//         BP_ROLE,
//         EMAIL_ADDRESS,
//         PHONE_NUMBER,
//         FAX_NUMBER,
//         WEB_ADDRESS,
//         ADDRESS_GUID,
//         BP_ID,
//         COMPANY_NAME,
//         LEGAL_FORM,
//         APPROVAL_STATUS,
//         address : Association to one ad on address.NODE_KEY = ADDRESS_GUID
//     }

define view Thai as
    select from po.po_i {
        PARENT_KEY,
        sum(GROSS_AMOUNT) as value  : Integer,
        sum(NET_AMOUNT)   as value1 : Integer,
        sum(TAX_AMOUNT)   as value2 : Integer
    }
    group by
        PARENT_KEY;
