<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS File Upload — agent index

LMS **ActivityAnswer plugin: learners upload files to the private file system** (file-upload assignments).
Depends on core `file`, `lms`. Version **1.0.2**. Core `^10||^11`.

**Security (good):** submissions go to the **private filesystem** (access-checked download, not public) —
ensure private FS is configured + download access restricted to learner/instructor; keep allowed extensions
restricted (core upload validation). No access role of its own beyond LMS/file access.
