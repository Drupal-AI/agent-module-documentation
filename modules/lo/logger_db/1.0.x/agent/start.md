<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logger DB — agent index

A **database storage backend (+ admin UI) for the Logger and Monolog modules** (store their log entries in the
DB, browsable in the admin). Config at `logger_db.settings`. Version **1.0.0-alpha4**. Core `^10||^11`.

Developer/logging — avoid logging secrets/PII; handle log growth (retention); gate the log UI to trusted
admins. No access role.
