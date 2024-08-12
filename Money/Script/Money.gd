extends Control

################################################################################
# Attributes
################################################################################
@onready var account_balance = $Background/BankContainer/Panel/VBoxContainer/HBoxContainer/AccountBalance
@onready var account_assets = $Background/BankContainer/Panel/VBoxContainer/HBoxContainer/AccountAssets
@onready var account_income = $Background/BankContainer/Panel/VBoxContainer/HBoxContainer/AccountIncome
@onready var account_debt = $Background/BankContainer/Panel/VBoxContainer/HBoxContainer/AccountDebt
@onready var account_net_worth = $Background/BankContainer/Panel/VBoxContainer/HBoxContainer/AccountNetWorth

var balance = 0
var assets = 0
var income = 0
var debt = 0
var netWorth = 0

################################################################################
# Called when the node enters the scene tree for the first time.
################################################################################
func _ready():
	pass # Replace with function body.

################################################################################
# Called every frame. 'delta' is the elapsed time since the previous frame.
################################################################################
func _process(delta):
	pass
	
################################################################################
# Custom functions
################################################################################

func saveGame():
	var MoneyDict = {}
	MoneyDict.Balance = account_balance.text
	MoneyDict.Assets = account_assets.text
	MoneyDict.Income = account_income.text
	MoneyDict.Debt = account_debt.text
	MoneyDict.NetWorth = account_net_worth.text
	return MoneyDict
	
func loadGame( dataToBeLoaded ):
	account_balance.text = dataToBeLoaded.Balance
	account_assets.text = dataToBeLoaded.Assets
	account_income.text = dataToBeLoaded.Income
	account_debt.text = dataToBeLoaded.Debt
	account_net_worth.text = dataToBeLoaded.NetWorth

func setBalance( value ):
	balance = value
	account_balance.text = formatNumber(balance)

func setAssets( value ):
	assets = value
	account_assets.text = formatNumber(assets)
	
func setIncome( value ):
	income = value
	account_income.text = formatNumber(income)

func setDebt( value ):
	debt = value
	account_debt.text = formatNumber(debt)	

func setNetWorth( value ):
	netWorth = value
	account_net_worth.text = formatNumber(netWorth)
	
func formatNumber(number):
	var prefix = ","
	var s = str(number)
	var n = s.length() - 3
	var end
	if (number >= 0):
		end = 0
	else:
		end = 1
	while n > end:
		s = s.insert(n,prefix)
		n-=3
	return s
################################################################################
# Signals
################################################################################
func _on_return_button_pressed():
	hide()
