# Changelog

All notable changes to docker container and github action will be documented in this file.  
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [6.3.3] - 2025-04-09

### Changed
- Upgrade Therion to 6.3.3

## [6.3.2] - 2025-04-09

### Changed
- Upgrade Therion to 6.3.2

## [6.3.1] - 2025-04-09

### Changed
- Upgrade Therion to 6.3.1

## [6.3.0] - 2025-04-09

### Changed
- Upgrade Therion to 6.3.0
- Based on Ubuntu 24.04 LTS
- Compiled with cmake

## [6.2.1-20240410] - 2024-04-10

### Fixed
- Rolled back Dockerfile without USER because it is a GitHub Actions requirement (#4)

## [6.2.1-slavic] - 2024-04-03

### Changed
- Added `texlive-lang-czechslovak` and `texlive-lang-cyrillic` packages (#2)
- Using `apt-get` instead of `apt` when building (#2)

## [6.2.1] - 2024-03-21

### Changed
- Upgrade Therion to 6.2.1
- Container runs with dedicated `therion` user