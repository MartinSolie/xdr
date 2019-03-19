%#include "xdr/Stellar-types.h"

namespace stellar
{

enum PollType
{
    SINGLE_CHOICE = 0
};

union PollData switch (PollType type)
{
case SINGLE_CHOICE:
    EmptyExt ext;
};

struct PollEntry
{
    uint64 id;
    uint64 permissionType;

    uint64 numberOfChoices;
    PollData data;

    uint64 startTime;
    uint64 endTime;

    AccountID ownerID;
    AccountID resultProviderID;

    bool signatureRequired;

    longstring details;

    EmptyExt ext;
};

}