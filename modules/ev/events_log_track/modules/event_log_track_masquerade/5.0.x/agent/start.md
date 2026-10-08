<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_masquerade — agent index

Submodule of **events_log_track**. Records **masquerade / unmasquerade** (user-impersonation)
sessions into the shared `event_log_track` table. Depends on `event_log_track` + contrib
**`masquerade`** (`masquerade:masquerade`).

- Handler (`hook_event_log_track_handlers`): type **`masquerade`**, title *Masquerade*,
  operations `Masquerade`, `Unmasquerade` — `EventLogTrackMasqueradeHooks`.
- Recording is done by an **event subscriber**, `EventLogTrackMasquerade` (service
  `event_log_track_masquerade`), on `KernelEvents::REQUEST`:
  - route `entity.user.masquerade` → operation `masquerade`, description "User <admin> (uid)
    started masquerading as <target> (uid)".
  - route `masquerade.unmasquerade` → operation `unmasquerade`, description reconstructs the
    admin from the session metadata bag and records stopping the masquerade.
  - (No `ref_numeric`/`ref_char` set; the actors are in the description.)

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
