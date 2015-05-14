require_relative "administrador"

class Presenter

  def self.print_page_faults
    page_faults = Administrador.get_page_faults
    puts "Page faults:"
    page_faults.each do |k,v|
      print "Proceso #{k}: #{v}"
    end
    puts
  end

  def self.print_swaps
    swap_ins  = Administrador.get_swap_ins
    swap_outs = Administrador.get_swap_outs

    puts "Swap ins:"
    swap_ins.each do |k,v|
      print "Proceso #{k}: #{v}\n"
    end

    puts
    puts "Swap outs:"
    swap_outs.each do |k,v|
      print "Proceso #{k}: #{v}\n"
    end
    puts
  end

  def self.print_turnaround_times
    puts "implementar..."
    puts
  end

  def self.hacer_reporte
    puts "REPORTE:\n"
    puts "-------------------"
    print_page_faults
    print_turnaround_times
    print_swaps
    puts "-------------------"
  end

end