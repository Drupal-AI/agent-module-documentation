<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create and Continue adds a save button to the node form that creates the node and returns a fresh empty form of the same type.

---

Bulk content entry is a real editorial task and Drupal's form does not acknowledge it. Adding forty staff profiles, a season of events, a catalogue of products or a set of imported-by-hand records means the same loop each time: fill the form, save, land on the created node, navigate back to the add form, wait for it to load, fill it again. The navigation and the page load are pure overhead repeated once per record, and the cognitive cost of losing the form is worse than the seconds — a person entering data works fastest when the interface does not change under them. A "save and add another" button is the standard remedy in every data-entry application, and it is one button. Version **2.0.0** on core `^10 || ^11`, no dependencies. Two things worth attaching. **Confirmation still matters**: the created node disappears from view immediately, so the message saying what was saved is the only feedback, and it needs to name the node and link to it — otherwise a mistake made forty times is discovered at the end. And **the pattern generalises beyond nodes**: taxonomy terms, media items, users and custom entities have the same loop and usually no equivalent button, so if bulk entry is the real requirement it is worth asking whether an importer would serve better — a spreadsheet and a migration beat forty forms whenever the data already exists somewhere.

---

- Add forty staff profiles quickly.
- Enter a season of events.
- Create several nodes in one sitting.
- Reduce navigation between saves.
- Speed up bulk content entry.
- Enter a catalogue of products.
- Add records from a paper list.
- Reduce page loads during data entry.
- Keep the form open after saving.
- Support a content migration by hand.
- Enter a set of announcements.
- Add multiple case studies.
- Reduce editorial fatigue.
- Support a launch content push.
- Enter a list of locations.
- Add several team members.
- Speed up repetitive creation.
- Support an editor entering many items.
