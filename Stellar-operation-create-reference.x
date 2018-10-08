%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateReference

    Add unique reference to database

    Threshold: high

    Result: CreateReferenceResult
*/

struct CreateReferenceOp
{
    string64 reference;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateReference Result ********/

enum CreateReferenceResultCode
{
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_REFERENCE = -1,
    ALREADY_EXISTS = -2
};

struct CreateReferenceSuccessResult
{
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateReferenceResult switch (CreateReferenceResultCode code)
{
    case SUCCESS:
        CreateReferenceSuccessResult success;
    default:
        void;
};

}