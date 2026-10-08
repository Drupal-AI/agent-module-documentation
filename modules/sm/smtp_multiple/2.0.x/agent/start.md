<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMTP Authentication Support (multiple) — agent index

Allows **different SMTP configurations per email key** (route different mail streams via different SMTP
servers). Depends on `smtp`. Version **2.0.0**. Core `^10||^11`.

**Security:** each SMTP config has server credentials — store as secrets; use TLS/STARTTLS. Mail/developer
feature; no content-access role.
