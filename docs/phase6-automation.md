# Phase 6 Automation

Phase 6 intentionally separates **collection** from **interpretation**.

Windows automation checks repository integrity, Git state, evidence presence, and privacy markers.
GCP automation checks the known runtime components and writes raw evidence locally.

Neither script performs exploitation, credential discovery, destructive actions, or public exposure changes.

## Important interpretation
A running vulnerable service is evidence of lab availability only. It is not evidence that an exploit succeeded.
WebGoat root HTTP 404 is recorded as endpoint validation pending rather than automatically treating the application as broken.
