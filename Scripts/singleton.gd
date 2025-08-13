extends Node

#player controls
const left_p1: String = "P1_Left"
const right_p1: String = "P1_Right"
const up_p1: String = "P1_Up"
const down_p1: String = "P1_Down"
const confirm_p1: String = "P1_Trick"
const left_p2: String = "P2_Left"
const right_p2: String = "P2_Right"
const up_p2: String = "P2_Up"
const down_p2: String = "P2_Down"
const confirm_p2: String = "P2_Trick"

#Used to save player's costume pick
enum Selection { GHOST, KNIGHT, PRINCESS, WITCH }
var costume_p1: Selection
var costume_p2: Selection
