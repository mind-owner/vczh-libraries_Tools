function Test-Workflow {
    Test-Vlpp-SubProject "Workflow" "LibraryTest"
    Test-Vlpp-SubProject "Workflow" "CompilerTest_GenerateMetadata"
    Test-Vlpp-SubProject "Workflow" "CompilerTest_LoadAndCompile"
    Test-Vlpp-Platform   "Workflow" "UnitTest_MergeCpp" Win32 "$PSScriptRoot\..\..\Workflow\Test\UnitTest\Release"
    Test-Vlpp-SubProject "Workflow" "CppTest"
    Test-Vlpp-SubProject "Workflow" "CppTest_Metaonly"
    Test-Vlpp-SubProject "Workflow" "CppTest_Reflection"
    Test-Vlpp-SubProject "Workflow" "RuntimeTest"
}

function Build-Workflow {
    # Run test cases
    Test-Workflow
}

function Update-Workflow {
    # Import
    Import-Project Workflow ("Vlpp","VlppOS","VlppRegex","VlppReflection","VlppParser2")

    # Update Parsers
    Update-Parser2 $PSScriptRoot\..\..\Workflow\Source\Parser\Syntax\Parser.xml

    # Release
    Release-Project Workflow
    Build-Sln $PSScriptRoot\..\..\Workflow\Tools\CppMerge\CppMerge\CppMerge.vcxproj Release x86
    Test-Single-Binary CppMerge.exe
}