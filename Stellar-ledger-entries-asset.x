// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum AssetPolicy
{
	TRANSFERABLE = 1,
	BASE_ASSET = 2,
	STATS_QUOTE_ASSET = 4,
	WITHDRAWABLE = 8
};



struct AssetEntry
{
    AssetCode code;
	AccountID owner;
    string64 name;
	AccountID preissuedAssetSigner; // signer of pre issuance tokens
	longstring description;
	string256 externalResourceLink;
	uint64 maxIssuanceAmount; // max number of tokens to be issued
	uint64 availableForIssueance; // pre issued tokens available for issuance
	uint64 issued; // number of issued tokens
	uint64 lockedIssuance; // number of tokens locked for entries like token sale. lockedIssuance + issued can not be > maxIssuanceAmount
    uint32 policies;
    longstring logoID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
