%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ASwapBidQuoteAsset
{
    AssetCode quoteAsset;
    uint64 price;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct AtomicSwapBidEntry
{
    uint64 bidID;
    AccountID ownerID;
    AssetCode baseAsset;
    BalanceID baseBalance;
    uint64 amount;
    uint64 createdAt;

    uint64 fee;
    uint64 percentFee;

    longstring details;

    ASwapBidQuoteAsset quoteAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}