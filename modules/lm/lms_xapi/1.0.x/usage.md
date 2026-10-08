<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS XAPI adds xAPI (Experience API) integration to the LMS module, sending learning activity statements to a Learning Record Store (LRS).

---

LMS XAPI connects the LMS (learning management) module to a Learning Record Store using xAPI
(Experience API / Tin Can) — as learners interact with courses and lessons, it emits xAPI statements
(actor–verb–object records of learning activity) to a configured LRS. This lets learning activity be
tracked and analysed centrally across systems, the standard pattern for e-learning analytics. It ships
submodules (`lms_xapi_activity`, `lms_xapi_lesson`, `lrs_xapi`) and depends on core File and the `lms`
module.

Use it on an LMS-based site that must report learning records to an LRS for analytics or compliance.
It sends activity data (who did what) to the LRS endpoint, authenticated with LRS credentials — store
those as secrets and be mindful that learner activity/PII is transmitted to the LRS (consent/privacy
considerations). It provides its own permissions.

---

- Send xAPI statements to an LRS.
- Track learning activity via xAPI.
- Integrate LMS with a Learning Record Store.
- Emit actor-verb-object statements.
- Record course/lesson interactions.
- Depend on the lms module and core File.
- Use lms_xapi_activity/lesson submodules.
- Configure the LRS endpoint and credentials.
- Store LRS credentials as secrets.
- Report learning records for compliance.
- Analyse learning across systems.
- Send learner activity to the LRS.
- Mind learner PII/consent.
- Provide its own permissions.
- Track e-learning analytics.
- Use the Experience API (Tin Can).
- Emit statements on lesson completion.
- Centralise learning records.
- Authenticate to the LRS.
- Support learning analytics.
