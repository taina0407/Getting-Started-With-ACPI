// Source: https://github.com/daliansky/OC-little
DefinitionBlock("", "SSDT", 2, "ACDT", "GPI0", 0)
{
    External(GPEN, FieldUnitObj)
    
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            GPEN = One
        }
    }
}