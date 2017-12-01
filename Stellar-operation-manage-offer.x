// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates, updates or deletes an offer

Threshold: med

Result: ManageOfferResult

*/
struct ManageOfferOp
{
    BalanceID baseBalance; // balance for base asset
	BalanceID quoteBalance; // balance for quote asset
	bool isBuy;
    int64 amount; // if set to 0, delete the offer
    int64 price;  // price of base asset in terms of quote

    int64 fee;

    // 0=create a new offer, otherwise edit an existing offer
    uint64 offerID;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageOffer Result ********/

enum ManageOfferResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,     // generated offer would be invalid
    PAIR_NOT_TRADED = -2, // it's not allowed to trage with this pair
    BALANCE_NOT_FOUND = -3,  // does not own balance for buying or selling
    UNDERFUNDED = -4,    // doesn't hold what it's trying to sell
    CROSS_SELF = -5,     // would cross an offer from the same user
	OFFER_OVERFLOW = -6,
	ASSET_PAIR_NOT_TRADABLE = -7,
	PHYSICAL_PRICE_RESTRICTION = -8, // offer price violates physical price restriction
	CURRENT_PRICE_RESTRICTION = -9,
    NOT_FOUND = -10, // offerID does not match an existing offer
    INVALID_PERCENT_FEE = -11,
	INSUFFICIENT_PRICE = -12
};

enum ManageOfferEffect
{
    CREATED = 0,
    UPDATED = 1,
    DELETED = 2
};

/* This result is used when offers are taken during an operation */
struct ClaimOfferAtom
{
    // emitted to identify the offer
    AccountID bAccountID; // Account that owns the offer
    uint64 offerID;
	int64 baseAmount;
	int64 quoteAmount;
	int64 bFeePaid;
	int64 aFeePaid;
	BalanceID baseBalance;
	BalanceID quoteBalance;

	int64 currentPrice;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageOfferSuccessResult
{

    // offers that got claimed while creating this offer
    ClaimOfferAtom offersClaimed<>;
	AssetCode baseAsset;
	AssetCode quoteAsset;

    union switch (ManageOfferEffect effect)
    {
    case CREATED:
    case UPDATED:
        OfferEntry offer;
    default:
        void;
    }
    offer;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageOfferResult switch (ManageOfferResultCode code)
{
case SUCCESS:
    ManageOfferSuccessResult success;
case PHYSICAL_PRICE_RESTRICTION:
	struct {
		int64 physicalPrice;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} physicalPriceRestriction;
case CURRENT_PRICE_RESTRICTION:
	struct {
		int64 currentPrice;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} currentPriceRestriction;

default:
    void;
};

}
