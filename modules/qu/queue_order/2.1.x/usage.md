<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue Order provides basic control over the execution order of Drupal's queue workers during cron, so higher-priority queues run first.

---

Drupal's queue system processes queues during cron, but the order in which queue workers run is not something core lets you control directly — it processes them as it finds them. On a site with several queues where one matters more than the others (a queue that sends time-sensitive notifications versus one doing background cleanup), that lack of ordering means the important work can wait behind the unimportant.

Queue Order adds basic control over that execution order, letting an administrator influence which queues are processed ahead of others during cron. It is a small operational tuning tool for sites where queue processing has become a bottleneck or a latency concern.

It is infrastructural and low on security surface — it changes scheduling, not access or data. The thing to confirm is that the ordering you set matches your actual priorities, and to remember that it controls order, not capacity: if cron time is the constraint, ordering decides what runs first but not whether everything runs.

---

- Control queue execution order.
- Run a priority queue first.
- Prioritise notification queues.
- Order queue workers on cron.
- Tune queue processing.
- Avoid important work waiting.
- Influence cron queue order.
- Run time-sensitive queues early.
- Manage several queues.
- Reduce queue latency.
- Set queue priorities.
- Process critical queues first.
- Order background jobs.
- Confirm ordering matches priorities.
- Tune a queue bottleneck.
- Schedule queues deliberately.
- Control worker order.
- Optimise cron processing.
- Sequence queue work.
- Manage queue scheduling.