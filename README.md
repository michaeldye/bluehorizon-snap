# bluehorizon-snap

## Introduction

**NOTE**: This project is deprecated in favor of http://github.com/open-horizon/horizon-pkg.

This project contains the Horizon client system bootstrapped to the Blue Horizon managed infrastructure.  You can install the client on a Ubuntu Snap capable system by executing `snap install --devmode --beta bluehorizon`. Alternatively, you can download a complete system image for various SBCs at http://bluehorizon.network.

Related Projects:

* `anax` (http://github.com/open-horizon/anax): The client control application in the Horizon system
* `raspbian-image` (http://github.com/open-horizon/raspbian-image): The Raspbian image builder for Raspberry Pi 2 and 3 models dedicated to Horizon
* `horizon-pkg` (http://github.com/open-horizon/horizon-pkg): A system for packaging Horizon system `deb`s for multiple distributions and architectures. It also produces Ubuntu snaps

## Operations

### Preconditions

* A development system running Ubuntu 16.04 classic with the packages `snapd` and `snapcraft` installed
* To publish the snap, an account at myapps.developer.ubuntu.com and listing as a collaborator on the bluehorizon project (contact mdye for this access)

#### Build `snap`

    snapcraft snap

#### Push `snap` to Ubuntu store

    snapcraft push bluehorizon_*.snap

#### Release `snap` to Ubuntu store (edge channel)

    snapcraft publish bluehorizon <revision> edge

### Development Shortcuts

* To save time rebuilding the snap, pre-fetch the golang dependencies: `(cd anax; make deps)`. The state created by executing this step can be removed with `(cd anax; make clean)`.
* During development, it isn't necessary to work with full-composed `snap` archives. Instead, you can create an exploded snap filesystem tree with `snapcraft prime` and install it for iterative development with `snap try ./prime`.
