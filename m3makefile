# m3_option("-keep")

overridepath = [ THISTREE, FULLTREE ]
importfrompath("kernel","m3core_sa",overridepath)

#############################################################################
# Turn on profiling for .c files
if equal(PROFILE, "TRUE")
	m3_option("-cc -pg")
end

#
# Do nothing after building the .a
#
proc library_hooks(x) is
  local lib_a  = format ("lib%s.a", x)
  write ("Done building ", lib_a, CR)
end	


include_dir ("fmtlex")
include_dir ("types")
include_dir ("atom")
include_dir ("list")
include_dir ("table")
include_dir ("rw")
include_dir ("sortedtable")
include_dir ("sort")
include_dir ("sequence")
include_dir ("splay")
include_dir ("dequeue")

m3_option ("-times")
m3_option ("-NoLoopholeWarning")

Library ("m3_sa")
