#Module TidalGear Battle System 
#Slogan... T.G.B.S. It's in the gear!

=begin
THIS is the TGBS script that creates a way for the player to jump
into a mech and reak havok on everything that exists. 

"Arkanos" is a file tied to several ".dll" libraries that use 
a several commands, systems, engine settings and system settings to run
TGBS for a specific environment. Arkanos comes with several versions.
It's features are as follows

Multi-language iterations of the all scripts and system settings. THE GIFT OF KNOWLEDGE
Multiple engines supported as well as the core functions. IS KNOWING
A GPU rendering engine. VISION
A Physics engine. LIFE AND UNDERSTANDING MATTER
A system checker (check for whether or not the system can run certain
features in Arkanos) FOR A TRUE GOD WILL NOT ENCOMBER HIS SERVANTS.
And Arkanos will not be write-protected because YOU SHALL BE AS GODS, 
its for modding purposes.
=end

module TGBS
 # 1. TIDAL GEAR EVENT ACCESSOR DATABASE
 class TGEAD 
  attr_accessor :gear # Object_type ID
  attr_accessor :gear_weapon # gear_weapon ID
  attr_accessor :gear_skill # gear_skill ID
  attr_accessor :gear_item # gear_item ID
  attr_accessor :gear_action # gear_action_execution
  attr_accessor :gear_target # gear_targeting_sys
  attr_accessor :gear_ay # gear_ay_mode 
  attr_accessor :gear_comm # gear_comm_type
  attr_accessor :gear_fleet # gear_fleet_number
  attr_accessor :gear_core # gear_interactions_console
  attr_accessor :gear_systems # gear_system_config
  attr_accessor :gear_list # gear_charts_owned
  attr_accessor :gear_part # gear_part_ID
  attr_accessor :gear_status # gear_status_overview
  attr_accessor :gear_num # gear_number_ID
  attr_accessor :gear_name # gear_name_ID
  attr_accessor :gear_sprite # gear_sprite chracter name for file 
  attr_accessor :gear_model # gear_model for 3D mode in RPG maker XP or in a different engine
  attr_accessor :gear_class # gear_class ID for each type of class that exists
  attr_accessor :gear_faction # gear_affiliation_design_type
  attr_accessor :gear_variable # gear_variable_type 
  attr_accessor :gear_commands # gear_command types for different action sets during battle
  attr_accessor :gear_modifier # gear_feul_generation_link for energy fusion consumption (different modifiers create different effects on your gear)
  attr_accessor :gear_window # gear_window pane for options 
  attr_accessor :gear_HP # I dont need to tell you what this is...
  attr_accessor :gear_FUEL # fuel for the gear.
  attr_accessor :gear_TP # Tech points
  attr_accessor :gear_AP # Ability points
  attr_accessor :gear_EP # Ether points
  attr_accessor :gear_FP # Aural Points
  attr_accessor :gear_INT # level of intelligence for the ether system 
  attr_accessor :gear_ARMR # resilience to damage taken 
  attr_accessor :gear_LUC # Crit chance and item drop chance increase
  attr_accessor :gear_ALRT # Level of alertness during combat for the ai level
  attr_accessor :gear_SPD # the movement speed of the gear 
  attr_accessor :gear_AGI # the evasion and quickness of the dodgeing of your gear  
  attr_accessor :gear_STR # the number of added attack power you gear has with its weapon  
  attr_accessor :gear_DEF # the number of added resilience when your gear is blocking/shielding from attacks 
  attr_accessor :gear_OHmeter # a meter that watches your gear and keeps it from overheating.
  attr_accessor :gear_menu_calling # The menu popup trigger
  attr_accessor :gear_menu_disabled # the menu popup disabler 
  attr_accessor :gear_message_window # the window for in battle notifiers
  attr_accessor :gear_pos_x # position of your gear on the battlefield for the x axis
  attr_accessor :gear_pos_y # position of your gear on the battlefield for the y axis
  attr_accessor :gear_pos_z # position of your gear on the battlefield for the z axis
  attr_accessor :gear_damage # a number modifier for the damage taken.
  attr_accessor :gear_damage_pop # a number that can be visually seen that represents the damage given or taken.
  attr_accessor :gear_menu_beep # the sound of the menu notifiers
  attr_accessor :gear_sigil # sigil graphic ID for each gear.
  attr_accessor :gear_windowskin_name # gear window skin name for all the panes that 
  # are called the system uses a separate windowskin for the gear UI

 # 2. GEAR MODE VAR SETTINGS
 
  def initialize
  @gear = 0
  @gear_weapon = {}
  @gear_skill = 0
  @gear_window = false
	@gear_message_window = false
  @gear_status = []
  @gear_num = 0
  @gear_model = ""
  @gear_name = ''
  @gear_HP = 0
  @gear_AP = 0
  @gear_TP = 0
  @gear_FP = 0
	@gear_EP = 0
	@gear_INT = 0
	@gear_ALRT = 0
	@gear_LUC = 0
	@gear_ARMR = 0
	@gear_STR = 0 
	@gear_AGI = 0 
	@gear_DEF = 0
	@gear_SPD = 0
  @gear_damage = nil
  @gear_damage_pop = false
  @gear_FUEL = 0
  @gear_variable = 0
  @gear_menu_calling = false
	@gear_menu_disabled = true
  @gear_menu_beep = false
  @gear_target = 0
  @gear_item = {}
	@gear_action = []
	@gear_ai = nil
	@gear_comm = []
	@gear_fleet = 0
	@gear_core = false
	@gear_systems = {}
	@gear_list = 0
	@gear_part = {}
	@gear_sprite = ''
	@gear_class = nil
	@gear_faction = nil
	@gear_commands = []
	@gear_pos_x = []
	@gear_pos_y = []
	@gear_pos_z = []
	@gear_OHmeter = 0 
  @gear_modifier = nil
  @gear_sigil = 0
  @gear_windowskin_name = ''

    File.new("ARKANOS.rb","a+")
    
if File.file?("ARKANOS.rb")
    Sephirot = File.read("ARKANOS.rb","a+")
    @gear_modifier = Sephirot
     else
        Sephirot = nil
        @gear_modifier = nil
    end
 end
end

 # 3. GEAR CORE SYSTEMS
 # Be sure to disable the system menu access when
 # this menu has been called during the 
 # in game fights..

 class Game_menu 
    def disablePrimmenu
    @disable_menu_access = true
    return nil
    end
 end

  class gearspritebase < Sprite_Base
   #access the database for sprites
   def access_gear_sprite
    RPG::Cache.character("gear_sprites/" + gear_sprite.gear_name)
    spw = bitmap.width
    sph = bitmap.height
    src_rect = Rect.new(0, 0, spw, sph)
    self.contents.bit(x - spw / 2, y - sph, bitmap, src_rect)
   end
end

class input

# Override keys for the control set in game.

    # the input on [A] = Z 
    # the input on [B] = X
    # the input on [C] = C , space, enter 
    # the input on [X] = A
    # the input on [Y] = S
    # the input on [Z] = D
    # the input on [L] = Q
    # the input on [R] = W
    
       def keys
        case set1
        when input.trigger?(Input::A)

        when input.trigger?(Input::B)   

        when input.trigger?(Input::C)

        when input.trigger?(Input::X)

        when input.trigger?(Input::Y)
       #openlist 
            @gear_menu_calling = true
        when input.trigger?(Input::Z)

        else
       
      end
        end
    end

  class coreUI

   end

  class coretemp

   end

 # 4. GEAR CORE AY
   # Artificial Yesoud this is a master list of all the gear commands that 
   # Gears can draw from this list during combat in order to follow through 
   # fot the user's command or the AY for that gear.

 class AYActionReferece

 end

 # 5. GEAR ARC ACTION BASE

 class pilotmode

  end

 class gearmode

  end

 class gearwindowbase < Window_Selectable
    # the only thing I think that would need to be set would be the 
    # dimentions given for the windows shown in the menu and calling them.
    # Other than that you would need a lot of class manipulations to 
    # aquire what you'd need. So this script just uses the in game stuff
    # alot.
    @gear_windowskin_name = RPG::Cache.graphics("TGBS/TGBS Windowskin/TidalGearXindowskinrevblack.png")

    if @gear_window != nil
        def initialize(gear)
        super(0, 64, 640, 480)
        self.contents = Bitmap.new(width - 32, height - 32)
        gear = gear
        refresh
         end
       else
      
       end
       #=================================================================
       # Refresh
       #=================================================================
       def gear_refresh
        self.contents.clear
        draw_gear_battler_graphic(@gear, 40, 112)
        draw_gear_sigil(@gear, 32, 32)
        draw_gear_name(@gear, 4, 0)
        draw_gear_state(@gear, 96, 64)
        draw_gear_hp(@gear, 96, 112, 172)
        draw_gear_ep(@gear, 96, 144, 172)
        draw_gear_fp(@gear, 96, 176, 172)
        draw_gear_ap(@gear, 96, 208, 172)
        draw_gear_tp(@gear, 96, 340, 172)
        draw_gear_INT(@gear, 96, 372, 172)
        draw_gear_ALRT(@gear, 96, 404, 172)
        draw_gear_LUC(@gear, 96, 436, 172)
        draw_gear_ARMR(@gear, 96, 468, 172)
        draw_gear_STR(@gear, 96, 500, 172)
        draw_gear_AGI(@gear, 96, 532, 172)
        draw_gear_DEF(@gear, 96, 564, 172)
        draw_gear_SPD(@gear, 96, 596, 172)
        self.contents.font.color = Mega_Man_ZX_Regular
        self.contents.draw_text(320, 48, 80, 32, "EXP")
        self.contents.draw_text(320, 80, 80, 32, "NEXT")
        self.contents.font.color = normal_color
        self.contents.draw_text(320 + 80, 48, 84, 32, @gear.exp_s, 2)
        self.contents.draw_text(320 + 80, 80, 84, 32, @gear.next_rest_exp_s, 2)
        self.contents.font.color = system_color
        self.contents.draw_text(320, 160, 96, 32, "Gear Parts")
        draw_gear_item_name($data_weapons[@gear.gear_weapon_id], 320 + 16, 208)
        draw_gear_item_name($data_armors[@gear.gear_part1_id], 320 + 16, 256)
        draw_gear_item_name($data_armors[@gear.gear_part2_id], 320 + 16, 304)
        draw_gear_item_name($data_armors[@gear.gear_part3_id], 320 + 16, 352)
        draw_gear_item_name($data_armors[@gear.gear_part4_id], 320 + 16, 400)
        draw_gear_item_name($data_armors[@gear.gear_part5_id], 320 + 16, 448)
        draw_gear_item_name($data_armors[@gear.gear_part6_id], 320 + 16, 496)
      end
      def gear_dummy
        self.contents.font.color = system_color
        self.contents.draw_text(320, 112, 96, 32, $data_system.words.weapon)
        self.contents.draw_text(320, 176, 96, 32, $data_system.words.part1)
        self.contents.draw_text(320, 240, 96, 32, $data_system.words.part2)
        self.contents.draw_text(320, 304, 96, 32, $data_system.words.part3)
        self.contents.draw_text(320, 368, 96, 32, $data_system.words.part4)
        self.contents.draw_text(320, 432, 96, 32, $data_system.words.part5)
        self.contents.draw_text(320, 496, 96, 32, $data_system.words.part6)
        draw_gear_item_name($data_weapons[@gear.gear_weapon_id], 320 + 24, 144)
        draw_gear_item_name($data_armors[@gear.gear_part1_id], 320 + 24, 208)
        draw_gear_item_name($data_armors[@gear.gear_part2_id], 320 + 24, 272)
        draw_gear_item_name($data_armors[@gear.gear_part3_id], 320 + 24, 336)
        draw_gear_item_name($data_armors[@gear.gear_part4_id], 320 + 24, 400)
        draw_gear_item_name($data_armors[@gear.gear_part5_id], 320 + 16, 448)
        draw_gear_item_name($data_armors[@gear.gear_part6_id], 320 + 16, 496)
    end


    def draw_gear_sigil(gear_sigil, x, y)
       gear_sigil = RPG::Cache.character("gear_sigils/" + gear_sigil.gear_name) 
       sw = gsigil.width
       sh = gsigil.height
       src_rect = Rect.new(0, 0, sw, sh)
       self.contents.blt(x - sw / 2, y - sh, bitmap, src_rect)
    end
    
       def draw_gear_battler_graphic(gear_sprite, x, y)
        bitmap = RPG::Cache.battler("gear_battlers/" + gear_sprite.battler_name)
        gbw = bitmap.width
        gbh = bitmap.height
        src_rect = Rect.new(0, 0, gbw, gbh)
        self.contents.blt(x - gbw / 2, y - gbh, bitmap, src_rect)
      end
    end   

 # 6. GEAR SKILL BASE
super 



class Gearskills

Gear_skill_name = Hash.new { |Hash, key| hash[key]}
skillNum = 0

def skillCall(gear_skill)

Gear_skill_name["ETHER AURA"] = 0
Gear_skill_name["ETHER SHIELD"] = 1
Gear_skill_name["ETHER CROSS"] = 2
Gear_skill_name["ETHER RESONANCE"] = 3
Gear_skill_name["FUEL CHARGE"] = 4
Gear_skill_name["PHOENIX FIRE"] = 5
Gear_skill_name["FEFNIR DAZE"] = 6
Gear_skill_name["RAGE"] = 7
Gear_skill_name["RHINO QUAKE"] = 8
Gear_skill_name["AERO TORRENT"] = 9
Gear_skill_name["HUNTER CHAFT"] = 10
Gear_skill_name["DARK CLEANSE"] = 11
Gear_skill_name["SPRINTING STRIKE"] = 12
Gear_skill_name["MAGNETIC AXEL"] = 13
Gear_skill_name["LIGHTING STRAFE"] = 14
Gear_skill_name["BURNING FIST"] = 15
Gear_skill_name["SUMMONNING SKY"] = 16
Gear_skill_name["MAGESTIC DANCE"] = 17
Gear_skill_name["DASTARD DICE"] = 18
Gear_skill_name["OPEN SKIES"] = 19
Gear_skill_name["RADIAL FIELD"] = 20


for i = 0 in gear_skill do
  skillNum += i
  i++
  return Gear_skill_name[skillNum]
end
end

#Gear_skill_name[""] = ##

end
 # 7. GEAR FLEET COMMAND SYSTEM
 
 # 8. GEAR FLEET CORE 

 # 9. GEAR SYSTEM AY COMMS (artificial Yesod)

 # 10. GEAR LIST

 # 11. GEAR LIST STATS

 # 12. GEAR CLASS LIST

 # 13. GEAR FACTIONTYPE LISTS

 # 14. GEAR WEAPONTYPE LISTS

 # 15. GEAR TARGET SETTINGS

end