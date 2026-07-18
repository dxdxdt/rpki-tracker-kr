import datetime

class Row:
	def __init__ (self, asn: str, name: str, rpki_cnt: int, total_cnt: int, ratio: float):
		self.asn = asn
		self.name = name
		self.rpki_cnt = rpki_cnt
		self.total_cnt = total_cnt
		self.ratio = ratio
		self.bars:str = None
		self.rank:int = None

def key_total_as_f (element: Row):
	return element.total_cnt

def key_rank_as_f (element: Row):
	return element.rank
