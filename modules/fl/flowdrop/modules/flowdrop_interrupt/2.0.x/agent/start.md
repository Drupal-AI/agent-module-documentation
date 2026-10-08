<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Interrupt (flowdrop_interrupt) — agent index

Submodule of **flowdrop**. **Human-in-the-loop**: a workflow pauses and requests input via
confirmations or forms, then resumes with the answer. Version **2.0.0**. Core `^11.3`.

The third option between "automate the decision and accept the risk" and "don't automate the
process" — right for publishing AI-drafted content, sending customer email, approving refunds,
deleting records.

Rests on **checkpointing** (`flowdrop_stategraph`): the run is stored and revived, **not** held
open — so a three-day approval does not occupy a queue worker.

**Design question to settle per workflow:** what happens when nobody answers (timeout, escalation,
wait forever), and who is notified that input is wanted.