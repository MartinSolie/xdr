%#include "xdr/Stellar-types.h"

namespace stellar
{

enum PollType
{
    SINGLE_CHOICE = 0
};

union PollSpecification switch (PollType type)
{
case SINGLE_CHOICE:
    EmptyExt ext;
};

struct PollEntry
{
    uint64 id;
    uint64 permissionType;

    uint64 numberOfChoices;
    PollSpecification specification;

    longstring details;

    EmptyExt ext;
};

}