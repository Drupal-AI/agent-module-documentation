BEE Hotel Event provides BAT-event maintenance utilities and purges old BAT events on cron.

---

A small helper submodule: on every cron run it instantiates EventMaintenance (src/Util/EventMaintenance.php) and calls deleteOldBatEvents() to remove stale bat_events created by the Bee Hotel booking/availability flow, preventing unbounded growth of the BAT availability tables. It ships no routes, permissions or config - just the cron hook and the maintenance utility. Depends only on bat.

---

- Automatically purge old BAT events on cron to keep tables lean.
- Provide an EventMaintenance utility other Bee Hotel code can reuse.
- Reduce database bloat from historical availability/booking events.
- Run maintenance with no configuration or manual steps.
- Keep BAT availability queries fast by trimming stale rows.
