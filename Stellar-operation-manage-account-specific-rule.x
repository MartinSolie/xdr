%#include "xdr/Stellar-ledger-keys.h"

namespace stellar
{

//: Actions that can be performed with account rule
enum ManageAccountSpecificRuleAction
{
    CREATE = 0,
    REMOVE = 1
};

//: CreateAccountRuleData is used to pass necessary params to create a new account rule
struct CreateAccountSpecificRuleData
{
    //: Resource is used to specify an entity (for some - with properties) that can be managed through operations
    LedgerKey ledgerKey;
    //: Value from enum that can be applied to `resource`
    AccountID* accountID;
    //: True if such `action` on such `resource` is prohibited, otherwise allows
    bool forbids;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: RemoveAccountRuleData is used to pass necessary params to remove existing account rule
struct RemoveAccountSpecificRuleData
{
    //: Identifier of existing account rule
    uint64 ruleID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: ManageAccountRuleOp is used to create, update or remove account rule
struct ManageAccountSpecificRuleOp
{
    //: data is used to pass one of `ManageAccountRuleAction` with required params
    union switch (ManageAccountSpecificRuleAction action)
    {
    case CREATE:
        CreateAccountSpecificRuleData createData;
    case REMOVE:
        RemoveAccountSpecificRuleData removeData;
    } data;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAccountRolePermissionOp Result ********/

//: Result codes of ManageAccountRuleResultCode
enum ManageAccountSpecificRuleResultCode
{
    //: Means that specified action in `data` of ManageAccountRuleOp was successfully performed
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no account rule with such id
    NOT_FOUND = -1,
    SALE_NOT_FOUND = -2,
    NOT_AUTHORIZED = -3,
    ALREADY_EXISTS = -4,
    REVERSED_ALREADY_EXISTS = -5,
    ENTRY_TYPE_NOT_SUPPORTED = -6
};

//: Result of operation applying
union ManageAccountSpecificRuleResult switch (ManageAccountSpecificRuleResultCode code)
{
case SUCCESS:
    //: Is used to pass useful params if operation is success
    struct {
        //: id of the rule that was managed
        uint64 ruleID;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } success;
default:
    void;
};

}
