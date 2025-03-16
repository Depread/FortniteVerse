
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
randomize_guns := class(creative_device):

    @editable 
    ItemGranter: item_granter_device = item_granter_device{}

    @editable
    EliminationManager : elimination_manager_device = elimination_manager_device{}


    @editable
    ScoreManager : score_manager_device = score_manager_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        ItemGranter.GrantItemToAll()
        EliminationManager.EliminationEvent.Subscribe(ElimEvent)
        ScoreManager.SetScoreAward(100)


    ElimEvent(MaybeAgent: ?agent): void=
        if(Agent := MaybeAgent?):
            var RandomNumber: int = GetRandomInt(0,82)
            Print("Random Number Is {RandomNumber}")
            ItemGranter.GrantItemIndex(Agent,RandomNumber)
            ScoreManager.Activate(Agent)
            Print("Score Is {ScoreManager.GetCurrentScore(Agent)}")



        