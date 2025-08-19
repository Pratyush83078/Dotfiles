# Build after 1st time

- git pull
- make , cmake --build , cargo build etc
- sudo make install ( if builded from make)

- When you MIGHT need to clean the cache (delete previous builds):
  - Major dependency updates
  - Build system configuration changes
  - Switching branches with significant differences
  - Persistent, unexplainable build errors
  - Specific build tools that don't handle increments well
  - Space concerns
