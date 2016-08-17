# PowerShell
All of the PowerShell Stuff

## Some Basic Rules

### General

- Does the function or script accomplish the intended task?
- Is there any comment-based help including examples?
- Is the function or script "advanced" using [CmdletBinding()]?
- Are risk mitigation parameters supported if appropriate?
- Does the code use aliases for cmdlets?
- Does the script or function follow the Verb-Noun Convention?
- Is the verb in the approved list?
- Is it the correct verb?
- Are the noun(s) consistent?
- Is the function or script in a module with a discoverable name?

### Parameters

- Do the Parameters have specified types?
- Are the parameters named appropriately?
- Are parameters set as mandatory when appropriate?
- Is any declarative parameter validation used?
- Are arrays allowed when appropriate?
- Is pipeline input allowed and implemented properly?
- Are switch parameters used to flag options?
- Do parameters have appropriate default values?
- Are "use cases" divided into ParameterSets?
- Are named parameters used instead of positional parameters?

### Output

- Is the output in the form of objects?
- Is output produced in the PROCESS block if possible?
- Are format cmdlets used?
- Is write-verbose used to supply user-directed output messages?
- Is write-warning or write-error used for problem messages?
- Is write-debug used for developer-directed output messages?

### Flow

- Are filtering operations as far to the left in pipelines as possible?
- Are pipelines used appropriately in place of sequential logic?
- Are pipelines overly used (extremely long pipelines?)

### Comments

- Are comments used to explain logic (and not statements)?
- Is commented-out code present?

### Error Handling

- Are try/catch/finally used for terminating errors?
- Are errors signaled with write-error?
- Are terminating errors forced with -ErrorAction STOP?
- Are console apps checked using $LastExitCode
- Do write-error calls use the -TargetObject parameter?

