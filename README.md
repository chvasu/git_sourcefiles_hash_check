This is a Linux Shell script to verify hashes of files pulled from Git repository (e.g. GitHub, GitLab, AWS CodeCommit, etc.).

It follows the follow steps:
1. Identify and report total number of files cloned from Git repository
2. Obtain original hashes of each file
3. Generate hash of each file on local workstation
4. Compare original hash value with generated hash value for each file
5. Report the result

Note: The initial repository variable (gitrepoloc) must be updated to the actual value, based on user's OS directory structure.

Instructions to run the script
$sh script.sh

Enjoy!
