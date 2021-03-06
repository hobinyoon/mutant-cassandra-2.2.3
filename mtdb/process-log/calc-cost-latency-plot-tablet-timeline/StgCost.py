import datetime


# $ / GB / Month
#   Cost calculation in a Excel file
INST_STORE=0.527583

EBS_SSD   =0.1

def InstStore(size_bytes, time_delta):
	# datetime.timedelta time_delta
	return INST_STORE * size_bytes * 0.000000001 * time_delta.total_seconds() / (365.25 / 12 * 24 * 3600)
	#                                  123456789

def EbsSsd(size_bytes, time_delta):
	return EBS_SSD    * size_bytes * 0.000000001 * time_delta.total_seconds() / (365.25 / 12 * 24 * 3600)
	#                                  123456789
