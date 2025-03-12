using { /Fortnite.com/Devices }
     using { /Verse.org/Simulation }
     using { /UnrealEngine.com/Temporary/UI }
     using { /Fortnite.com/UI }
     using { /UnrealEngine.com/Temporary/SpatialMath }
     using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }
    using { /UnrealEngine.com/Temporary/Diagnostics }
    using { /Fortnite.com/UI}
    using { /UnrealEngine.com/Temporary/UI }
    using { /UnrealEngine.com/Temporary/SpatialMath }
    using { /Fortnite.com/Playspaces }
    using { /Fortnite.com/Characters }
		    
     interactable_health_slider := class(creative_device): 
        var NewShield : float = 100.0
        var NewHealth : float = 100.0 

        @editable
        spawner1:player_spawner_device=player_spawner_device{}
        @editable
        spawner2:player_spawner_device=player_spawner_device{}
        @editable
        spawner3:player_spawner_device=player_spawner_device{}
        @editable
        spawner4:player_spawner_device=player_spawner_device{}
        @editable
        spawner5:player_spawner_device=player_spawner_device{}
        @editable
        spawner6:player_spawner_device=player_spawner_device{}
        @editable
        spawner7:player_spawner_device=player_spawner_device{}
        @editable
        spawner8:player_spawner_device=player_spawner_device{}
        @editable
        spawner9:player_spawner_device=player_spawner_device{}
        @editable
        spawner10:player_spawner_device=player_spawner_device{}
        @editable
        spawner11:player_spawner_device=player_spawner_device{}
        @editable
        spawner12:player_spawner_device=player_spawner_device{}
        @editable
        spawner13:player_spawner_device=player_spawner_device{}
        @editable
        spawner14:player_spawner_device=player_spawner_device{}
        @editable
        spawner15:player_spawner_device=player_spawner_device{}
        @editable
        spawner16:player_spawner_device=player_spawner_device{}
        

        
        # Set the Button device in the Editor to reference the device in the level
        @editable
        MyButton : button_device = button_device{}

        
        # Localizable message to display as text in the UI
        TextForMyUI<localizes> : message = "Close"
        
        # A mapping between the Player and the widget that may have been added to their UI
        var MaybeMyUIPerPlayer : [player]?canvas = map{}
        
        # Runs when the device is started in a running game
        OnBegin<override>()<suspends> : void = 

            spawner1.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner2.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner3.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner4.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner5.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner6.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner7.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner8.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner9.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner10.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner11.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner12.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner13.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner14.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner15.SpawnedEvent.Subscribe(PlayerSpawned)
            spawner16.SpawnedEvent.Subscribe(PlayerSpawned)
            MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

        PlayerSpawned(Agent:agent):void=
            if(Player:=Agent.GetFortCharacter[]):
                Print("PLAYER HEALTH CHANED ON SPAWN")
                Player.SetMaxHealth(NewHealth)
                Player.SetHealth(NewHealth)
                Player.SetMaxShield(NewShield)
                Player.SetShield(NewShield)
        
        # A custom UI can only be associated with a specific player, and only that player can see it
        HandleButtonInteraction(Agent : agent) : void =
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                else:
                    NewUI := CreateMyUI()
                    PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.All})
                    if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
        
        # Create a UI with an interactable slider, and a button that removes the UI from the screen
        CreateMyUI() : canvas =
            MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}
        
            MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)
        
            MyHealthSlider : slider_regular = slider_regular:
                DefaultValue := 100.0
                DefaultMinValue := 1.0
                DefaultMaxValue := 100.0
                DefaultStepSize := 1.0

            MyShieldSlider : slider_regular = slider_regular:
                DefaultValue := 100.0
                DefaultMinValue := 0.0
                DefaultMaxValue := 100.0
                DefaultStepSize := 1.0
        
            MyHealthSlider.OnValueChanged().Subscribe(HandleValueChangedHealthSlider)
            MyShieldSlider.OnValueChanged().Subscribe(HandleValueChangedShieldSlider)
        
            MyInteractableWidgets : canvas = canvas:
                Slots := array:
                    canvas_slot:
                        Anchors := anchors{Minimum := vector2{X := 0.55, Y := 0.6}, Maximum := vector2{X := 0.55, Y := 0.6}}
                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := vector2{X := 0.5, Y := 0.5}
                        SizeToContent := true
                        Widget := MyHealthSlider
                    canvas_slot:
                        Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.7}, Maximum := vector2{X := 0.5, Y := 0.7}}
                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := vector2{X := 0.5, Y := 0.5}
                        SizeToContent := true
                        Widget := MyUIButton
                    canvas_slot:
                        Anchors := anchors{Minimum := vector2{X := 0.45, Y := 0.6}, Maximum := vector2{X := 0.45, Y := 0.6}}
                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                        Alignment := vector2{X := 0.5, Y := 0.5}
                        SizeToContent := true
                        Widget := MyShieldSlider
        
            return MyInteractableWidgets 





        
        # When the player interacts with the slider, the new value is printed to the screen
        HandleValueChangedHealthSlider(Message : widget_message) : void =
            if:
                PlayerUI := GetPlayerUI[Message.Player]
                MyUI := MaybeMyUIPerPlayer[Message.Player]?
                ChangedSlider := slider_regular[Message.Source]
            then:
                Print("Player changed slider value to {ChangedSlider.GetValue()}")
                AllPlayers:[]player = GetPlayspace().GetPlayers()
                    for(Player : AllPlayers, Character := Player.GetFortCharacter[]):
                        MyCharacterHealth:float = Character.GetHealth()
                        if(MyCharacterHealth=200.00): 
                            Print("Max Health")
                        else:
                            Character.SetMaxHealth(ChangedSlider.GetValue())
                            Character.SetHealth(ChangedSlider.GetValue())
                            set NewHealth = ChangedSlider.GetValue()
                            Print("Changing Health")
                            

        HandleValueChangedShieldSlider(Message : widget_message) : void =
            if:
                PlayerUI := GetPlayerUI[Message.Player]
                MyUI := MaybeMyUIPerPlayer[Message.Player]?
                ChangedSlider := slider_regular[Message.Source]
            then:
                Print("Player changed slider value to {ChangedSlider.GetValue()}")
                #Playspace:fort_playspace = GetPlayspace()
                #AllPlayers:[]player = Playspace.GetPlayers()
                AllPlayers:[]player = GetPlayspace().GetPlayers()
                    for(Player : AllPlayers, Character := Player.GetFortCharacter[]):
                        MyCharacterHealth:float = Character.GetHealth()
                        if(MyCharacterHealth=200.00): 
                            Print("Max Shield")
                        else:
                            Character.SetMaxShield(ChangedSlider.GetValue())
                            Character.SetShield(ChangedSlider.GetValue())
                            set NewShield = ChangedSlider.GetValue()
                            Print("Changing Shield")


                <#
                if (Player:player = AllPlayers[0]):
                    if (FortniteCharacter:fort_character = Player.GetFortCharacter[]):
                        MyCharacterHealth:float = FortniteCharacter.GetHealth()
                        if(MyCharacterHealth=200.00): 
                            Print("Max Shield")
                        else:
                            FortniteCharacter.SetShield(ChangedSlider.GetValue())
                #>   

        
        # The custom UI is removed when the player selects the Close button option
        HandleSelectedUIButton(Message : widget_message) : void =
            if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
                Print("Player selected {SelectedButton.GetText()}")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
