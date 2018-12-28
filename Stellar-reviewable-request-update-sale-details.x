%#include "xdr/Stellar-types.h"

namespace stellar {

struct UpdateSaleDetailsRequest {
    uint64 saleID; // ID of sale to update details
    longstring newDetails;

    uint32 sequenceNumber;
    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}