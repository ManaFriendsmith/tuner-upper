# ABOUT

This is a Factorio mod that reworks the quality mechanic. The point is to make quality production more interesting to engage with than the same recycler loop over and over, make it easier to dip into early, and improve the ratio of designing builds to fiddly filter-setting.

- There are 2 new machines, the Tune-Up Station and the Molecular Purifier, which have a high chance to upgrade the quality of an item at the cost of other resources.
- The tune-up station upgrades crafted items and is generally pretty efficient but demands a variety of ingredients. The molecular purifier upgrades raw materials but is power and resource hungry.
- Quality can never go up by more than one step per process. This means you only need one filter splitter for each production block with quality, or none if you can get the quality chance above 100%.
- Recyclers have a chance to downgrade the quality of items they process by 1 tier. Quality modules mitigate this and speed modules worsen it. Recyclers CANNOT increase quality.
- Quality modules can still be used in regular production and are buffed so they aren't necessarily always worse than productivity modules.
- Max level of LDS/Blue chip/Rocket fuel productivity researches is capped at 10; LDS casting is removed but the normal recipe from plates can be performed in the foundry.
- The net effect of these changes is that upcycling is still about as good as it was before but there are other, better methods to get quality entities and materials.

For example, let's say you want quality medium power poles. You can craft them with quality modules to get the occasional uncommon. To upgrade the normals you can combine them with green circuits in the tune-up station. If you want rares, well, you're going to need to combine the uncommons with uncommon green circuits (which can be sourced by tuning up normal green circuits, or crafting them from uncommon ingredients, or recycling something else uncommon (that it's now possible to deliberately produce at scale)...).

And if you unlock higher qualities later but don't need them on power poles in particular, you don't need to worry about epics and legendaries clogging up the output of your power pole production. You can decide for yourself how far to take quality for each item, instead of having to standardize everything at either normal or legendary.

Also has optional settings to make quality science production valuable, nerf the power of quality items, and add extra byproducts to upgrading recipes.

# DEPENDENCIES

- [pf-functions](https://github.com/ManaFriendsmith/pf-functions) - Library and some misc functionality that does not belong to any one content mod

# KNOWN ISSUES

- If you reduce a machine's quality chance mid-craft, it will output items at its default quality even if the lower quality chance is greater than 100%. This is true without this mod but is not usually an issue because of the ubiquity of quality filter splitters. You can get around this by ensuring the machine is not crafting before messing with its modules or just having filters anyway. This is ["working as intended for 2.0 and fixed in 2.1"](https://forums.factorio.com/viewtopic.php?p=691981#p691981)
- Recycler module slots are reduced to 2, so the 3rd and 4th modules in them will be deleted if you add this to an in-progress save. (balance changes like this are subject to change and I might put them back tbh)

# CREDITS

- Planetfall - Code
- [hurricane046](https://www.figma.com/proto/y1IQG08ZG2jIeJ5sTyF4MP/Factorio-Buildings?node-id=14934-304&node-type=frame&t=tk88gXWNIga60zMr-0&scaling=scale-down-width&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=2585%3A1158&hotspot-hints=0&hide-ui=1) - Machine Graphics
