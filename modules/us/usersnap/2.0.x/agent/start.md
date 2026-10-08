<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Usersnap — agent index

Integrates the **Usersnap visual-feedback/bug-report widget** (screenshots + reports from the page; injected
with an API key). Provides permissions. Version **2.x** (dev). Core `^10||^11`.

Third-party integration — loads **Usersnap third-party JS** (trust the vendor); feedback/screenshots sent to
**Usersnap** (may capture page content — careful on sensitive pages; privacy); handle the API key as a secret.
No access role beyond permission.
