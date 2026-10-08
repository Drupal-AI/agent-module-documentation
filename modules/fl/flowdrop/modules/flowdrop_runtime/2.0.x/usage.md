<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Runtime executes workflows, processing them through a queue and reporting progress in real time.

---

Executing a workflow is not like calling a function. Steps can be slow (a model call), can fail transiently (an HTTP timeout), can fan out over many items, and can outlive the request that started them. Running them inline in a web request produces timeouts and half-finished work; running them on a queue produces something that survives, retries and can be observed.

That is what this submodule provides: the engine that takes a workflow definition, walks it, and processes each unit of work through Drupal's queue system, with real-time monitoring so an operator can see where a run has got to rather than waiting for it to finish or fail.

The monitoring half matters as much as the execution half. A visual editor makes workflows easy to build and correspondingly easy to build wrong; being able to watch a run step through its nodes is the difference between debugging a workflow and guessing at it.

It pairs with `flowdrop_pipeline` (which tracks the state of a whole run) and `flowdrop_job` (which tracks a single node execution) — the runtime is what creates and advances them.

---

- Execute a workflow.
- Process workflow steps through a queue.
- Survive a step that outlives the request.
- Retry a transiently failing step.
- Watch a run progress in real time.
- Debug where a workflow stopped.
- Run long workflows without web timeouts.
- Process many items without blocking.
- Report execution status to an operator.
- Recover a run after a failure.
- Schedule workflow processing on cron.
- Scale execution with queue workers.
- Trace a run through its nodes.
- Correlate jobs with their pipeline.
- Monitor workflow throughput.