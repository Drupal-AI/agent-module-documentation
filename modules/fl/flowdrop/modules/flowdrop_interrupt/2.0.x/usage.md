<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Interrupt lets a running workflow stop and ask a person something — a confirmation, a choice, a form — then continue with the answer.

---

Full automation is the wrong goal for a lot of processes. Publishing content an AI drafted, sending an email to a customer, approving a refund, deleting records: these want a machine to do the work and a person to say yes. Without a pause mechanism the choice is to automate the decision (and accept the risk) or not automate the process at all.

This submodule adds the third option. A workflow reaches an interrupt node, persists its state, and surfaces a request — a confirmation or a form — to whoever is responsible. When they answer, the run resumes with their input as data the rest of the workflow can act on.

The mechanics rest on checkpointing (see `flowdrop_stategraph`): the run is not held open waiting, it is stored and revived. That distinction matters operationally, because an approval that takes three days must not occupy a queue worker for three days.

The design question to settle per workflow is what happens when nobody answers — a timeout, an escalation, or a run that waits indefinitely — and who is notified that an answer is wanted.

---

- Pause a workflow for human approval.
- Ask a person to confirm an action.
- Collect input mid-workflow with a form.
- Approve AI-drafted content before publishing.
- Confirm before sending a customer email.
- Gate a destructive step behind a person.
- Resume a workflow with a person's answer.
- Store a paused run rather than holding a worker.
- Support approvals that take days.
- Route an approval to a responsible role.
- Notify someone that input is wanted.
- Escalate an unanswered approval.
- Record who approved what.
- Branch on the answer given.
- Model a review step in an automated process.