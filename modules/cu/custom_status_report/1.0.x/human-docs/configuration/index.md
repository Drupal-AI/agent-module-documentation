# Configuration

Custom Status Report adds a single settings page where you decide which cards
appear in the **General System Information** section of the core Status Report.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → System → Custom Status Report**, or navigate directly
   to `/admin/config/system/custom-status-report`.

## Show or hide status cards

The form lists the available cards. For each one you can choose whether it appears
on the Status Report page:

- **Hide default cards** you don't need, to cut down on noise and keep the report
  focused on what matters to your site or team.
- **Show custom cards** provided by your own module (or another module that
  supports Custom Status Report), so extra statuses you care about show up
  alongside the built-in ones.

Make your selections and **save** the form. Then open **Reports → Status report**
(`/admin/reports/status`) to see the result — hidden cards are gone, and any
enabled custom cards now appear in the General System Information section.

> **Adding your own card?** A custom card comes from code in a module that
> integrates with Custom Status Report. Once such a module is enabled, its card
> becomes selectable on this settings form; toggling it here controls whether it's
> displayed.
