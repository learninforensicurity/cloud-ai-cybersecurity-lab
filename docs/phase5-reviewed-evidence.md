# Phase 5 — Reviewed Evidence

The raw runtime evidence is retained locally as the original validation record.

For repository publication, use the `review-evidence.sh` script to create a reviewed copy.

The reviewed copy:
- removes the machine-specific evidence path;
- redacts the Open WebUI published address;
- replaces the broad socket listing with project-relevant listener information;
- records WebGoat honestly as running with root-endpoint validation pending;
- does not claim exploit success.

Do not modify or delete the raw evidence until the reviewed copy has been checked.
