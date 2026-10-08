<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Publish — agent index

Adds a **permission to publish/unpublish webforms** (control form availability by role, separate from full
webform admin). Depends on `webform`. Provides permissions. Version **1.0.2**. Core `^10||^11`.

Forms/workflow — **access-relevant**: grants a publish-state permission (publishing makes a form accept
submissions) — gate to appropriate roles. Layers on Webform's access.
