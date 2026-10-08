<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS XAPI — agent index

Integrates the **LMS** module with a **Learning Record Store (LRS)** via **xAPI** — emits
actor-verb-object learning statements on course/lesson activity. Submodules `lms_xapi_activity`,
`lms_xapi_lesson`, `lrs_xapi`. Depends on core `file`, `lms`. Version **1.0.0-beta1**. Core
`^10.3||^11`. Provides permissions.

Store LRS credentials as secrets; learner activity/PII is sent to the LRS (consent/privacy applies).
