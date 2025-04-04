untyped
global function RunPanel_DisplayRun
global function RunPanel_GetFocus
global function RunPanel_LoseFocus

void function RunPanel_DisplayRun( var panel, Run run )
{
    int timestamp = GetUnixTimestamp() - run.timestamp
    int index = GetRunIndex(run)

    var time = Hud_GetChild(panel, "RunLabel")


    if (run.seconds < 3600)
        Hud_SetText(time, FormatTime(run.seconds, run.microseconds))
    else
        Hud_SetText(time, FormatTime(run.seconds)) // doesnt have the .00 part 

    var dateLabel = Hud_GetChild(panel, "Date")
    // Hud_SetRotation( dateLabel, 45 ) 
    if (timestamp > 86400)
        Hud_SetText(dateLabel, (timestamp / 86400) + "d")
    else if (timestamp > 3600)
        Hud_SetText(dateLabel, (timestamp / 3600) + "h")
    else if (timestamp > 60)
        Hud_SetText(dateLabel, (timestamp / 60) + "m")
    else
        Hud_SetText(dateLabel, (timestamp) + "s")

    Hud_SetVisible(Hud_GetChild(panel, "PBStar"), run.isPB)
    
    var categoryBG = Hud_GetChild(panel, "CategoryBG")
    var categoryName = Hud_GetChild(panel, "CategoryName")
    vector color = GetCategoryColor(run.category)
    
    bool isIL = IsILCategory(run.category)
    string map
    if (isIL)
    {
        map = run.category.slice(run.category.find("_") + 1, run.category.len())
    }
    string categoryDisplayName = isIL ? GetLevelName(map) : run.category
    int x = Hud_GetX(categoryBG) - Hud_GetX(categoryName)
    
    Hud_SetText(categoryName, categoryDisplayName.toupper())
    Squircle_SetSize(categoryBG, abs(x) * 2 + Hud_GetTextWidth(categoryName), 24)
    Squircle_SetColor(categoryBG, int(color.x), int(color.y), int(color.z), 255)
}

void function RunPanel_GetFocus( var button )
{
    var panel = Hud_GetParent( button )

    Hud_SetColor( Hud_GetChild(panel, "RunSqaure"), 255, 255, 255, 255 )
    Hud_SetColor( Hud_GetChild(panel, "RunLabel"), 30, 30, 30, 255 )
    Hud_SetColor( Hud_GetChild(panel, "Date"), 30, 30, 30, 255 )
}

void function RunPanel_LoseFocus( var button )
{
    var panel = Hud_GetParent( button )

    Hud_SetColor( Hud_GetChild(panel, "RunSqaure"), 30, 30, 30, 255 )
    Hud_SetColor( Hud_GetChild(panel, "RunLabel"), 255, 255, 255, 255 )
    Hud_SetColor( Hud_GetChild(panel, "Date"), 255, 255, 255, 255 )
}