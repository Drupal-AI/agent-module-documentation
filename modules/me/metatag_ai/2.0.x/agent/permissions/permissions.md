<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag AI permissions

From `metatag_ai.permissions.yml`. Both are `restrict access: TRUE` (trusted-admin permissions).

| Permission | Gates | Notes |
|---|---|---|
| `administer metatag content` | The settings form route `metatag_ai.content_settings` **and** whether the "Generate Metatag" button renders on node forms (checked in `metatag_ai_form_alter`). | This is the one editors need to actually use the feature. |
| `administer metatag ai` | Declared "control the main settings" but is **not referenced by any route or check** in this version — effectively inert here. | Present for forward/back compatibility. |

Practical note: the generation button is shown only to users holding `administer metatag content`
(plus an active AI chat provider and a selected content type). There is no lower-privilege,
anonymous, or per-node path that triggers AI generation.
