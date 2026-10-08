<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Playground is a chat-based surface for running a workflow by hand and watching what it does.

---

The gap between building a workflow and trusting it is testing, and testing an event-triggered workflow is awkward: you have to produce the event, then find the run, then read the jobs. The playground removes that loop — pick a workflow, give it an input, watch it execute, see the output.

For conversational workflows the chat interface is the natural shape, since that is how the workflow will actually be used. For non-conversational ones it is still the quickest way to exercise a graph with a known input and confirm each node behaves, before wiring a trigger to it.

It pairs with `flowdrop_job` and `flowdrop_pipeline` for the detail: the playground shows you the run, those hold the per-node inputs and outputs when you need to look closer. Treat it as a development tool — it is a surface for running arbitrary workflows on demand, which is a capability worth restricting on a production site.

---

- Run a workflow by hand.
- Test a workflow without producing a trigger event.
- Watch a workflow execute step by step.
- Try a conversational workflow interactively.
- Confirm a node behaves before wiring a trigger.
- Exercise a graph with a known input.
- Reproduce a reported workflow problem.
- Compare output for different inputs.
- Debug alongside job and pipeline records.
- Demonstrate a workflow to a stakeholder.
- Iterate quickly while building.
- Validate a change before deploying it.
- Restrict on-demand execution in production.
- Onboard a new author to an existing workflow.
- Check a workflow after a model change.