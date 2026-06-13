extends Node

const TILE_FLOOR = 0
const TILE_WALL = 1
const TILE_EXIT = 2
const TILE_TRAP = 3
const TILE_BONE = 4
const TILE_ALTAR = 5
const TILE_GATE = 6

const TILE_SIZE = 64
const MAP_COLS = 10
const MAP_ROWS = 10
const UI_HEIGHT = 80

const MAP_WIDTH = TILE_SIZE * MAP_COLS
const MAP_HEIGHT = TILE_SIZE * MAP_ROWS
const MAP_OFFSET = Vector2(0, UI_HEIGHT)

const MAX_HEARTBEATS = 10
