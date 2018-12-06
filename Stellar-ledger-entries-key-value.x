
%#include "xdr/Stellar-types.h"

namespace stellar
{

    enum KeyValueEntryType
    {
        UINT32 = 1,
        STRING = 2,
        UINT64 = 3
    };


    union KeyValueEntryValue switch (KeyValueEntryType type)
    {
        case UINT32:
            uint32 ui32Value;
        case STRING:
            string stringValue<>;
        case UINT64:
            uint64 ui64Value;
    };

    struct KeyValueEntry
    {
        longstring key;

        KeyValueEntryValue value; // todo docs

        // reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };
}