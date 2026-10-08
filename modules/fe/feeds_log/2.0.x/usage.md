<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Log records feeds' unimported records log.

---

Feeds Log records the items a Feeds import did **not** import — a log of skipped/unimported feed
records — so you can review and debug why source rows were dropped during a Feeds import. It depends on the
Feeds module, in the Feeds package.

Use it to diagnose Feeds imports (what was skipped and why). It is an integration/logging feature. Data
handling note: the log captures **source feed data** for the unimported records, which may include personal
or otherwise sensitive content pulled from the source; that data is stored in the site and readable by users
with access to the log — treat the log accordingly and prune it. It has no access-control role. Review the
import log.

---

- Log records Feeds did not import.
- Show why source rows were dropped.
- Debug Feeds imports.
- Depend on the Feeds module.
- Capture skipped feed records.
- Store the unimported log.
- KNOW the log may hold sensitive source data.
- Restrict/prune the log accordingly.
- Have no access-control role.
- Review the import log.
- Handle import logging.
- Diagnose skipped rows.
- Log unimported records.
- Handle the log.
- Debug imports.
- Review skipped records.
- Handle Feeds logging.
- Store import failures.
- Configure the log.
- Track unimported items.
