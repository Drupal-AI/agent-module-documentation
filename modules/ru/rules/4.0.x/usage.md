Rules lets site builders define conditionally executed actions that react to events happening on the site (the classic event-condition-action, or ECA, model) without writing code.

---

Rules provides a **Reaction Rule** system: you pick an **event** (an entity is saved, a user logs in, cron runs, a system log entry is created, etc.), attach any number of **conditions** that must pass, and list the **actions** to execute when they do. Rules are stored as `rules_reaction_rule` config entities and are triggered automatically by a generic event subscriber that listens on the Symfony/Drupal event dispatcher. Reusable logic can be saved as a `rules_component` config entity and invoked as an action from other rules or from code. Everything is built on an **expression** engine (`rules_rule`, `rules_and`, `rules_or`, `rules_loop`, `rules_action`, `rules_condition`, `rules_action_set`) that nests conditions and actions and passes data between them through the **typed_data** module, so an action's output can feed a later action. Actions and conditions are plugins (`RulesAction` and `Condition`) discovered via attributes/annotations, and the module ships many built-in ones for entities, nodes, users, paths, system messages, email, and banning IPs. Site builders manage rules through a UI at **Admin → Configuration → Workflow → Rules**, and developers can build, save, and execute rules and components programmatically or manage them with Drush. Data can be transformed on the way into actions using data processors (token replacement, numeric offset).

---

- React to a node being published by sending a notification email to an editor.
- Automatically add a role to a user the first time they log in.
- Show a site message when a specific content type is created.
- Block a user account when a condition about their fields is met.
- Ban or unban an IP address as an action in response to an event.
- Redirect a visitor to another page after a form/entity event.
- Run maintenance actions on cron (the "Cron maintenance tasks are performed" event).
- Set a field value on an entity just before it is saved (entity presave event).
- Promote or make sticky a node automatically based on conditions.
- Create a companion entity automatically when another entity is inserted.
- Build a reusable "component" that sends a templated email, then call it from many rules.
- Loop over a list (e.g. multi-value field or referenced entities) and act on each item.
- Compare data values (equals, contains, is empty) as conditions before acting.
- Check a user's roles or field access before running privileged actions.
- Convert or calculate data values (data convert, calculate value) inside a rule.
- Add or remove items from a list variable during rule execution.
- Fetch an entity by ID or by field value and act on it.
- Create or delete a URL path alias as an action.
- Email all users of a given role when an event fires.
- Use tokens to build dynamic action input via the token data processor.
- Enable, disable, or delete reaction rules from the command line with Drush.
- Export rules as configuration and deploy them between environments.
- Split administration between "reactions", "components", and "settings" using granular permissions.
- Turn on the Rules debug log to trace why a rule did or did not fire.
- Extend Rules with a custom action plugin for domain-specific logic.
- Add a custom condition plugin to gate rules on project-specific state.
- Define a new triggerable event in a `*.rules.events.yml` file for other rules to react to.
- Provide a custom data processor to transform action input values.
- Register a custom Rules UI so a third-party config entity can host embedded rules.
