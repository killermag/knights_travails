require 'pry-byebug'
require_relative 'Node'
class Algo 
  attr_accessor :parents ,:extender
  def initialize 
    parents = Array.new
    extender = Array.new
  end
  

  def to_Pos!(arg)
    if arg.is_a?(Array)
     arg.map! do |x| 
        x.pos
      end
    else 
      arg = arg.pos  
    end  
    arg 
  end 

  def findParent(node,parents,aR=[])
    return if node.pos == parents[0].pos  
    parents.each do |pNode|
      if pNode.array.include?(node)
      aR.unshift(pNode.pos)
      findParent(pNode,parents,aR)
      end 
    end 
    return aR  
  end 
 
  
  def knight_moves(sP,eP)
    return 0 if sP[0] < 1 || sP[0] > 8 || sP[1] < 1 || sP[1] > 8 || eP[0] < 1 || eP[0] > 8 || eP[1] < 1 || eP[1] > 8 
    return sP if sP == eP 
    extender,parents = Array.new,Array.new 
    to_Pos!(eP_moves = moves(eP))
    sP_Node = Node.new(sP)
    extender << sP_Node
    result = Array.new
    if to_Pos!(moves(sP)).include?(eP)
      result << sP << eP
    else  
      while !result.include?(sP)
        eMoves = moves(extender[0].pos)
        extender[0].array = eMoves
        extender << eMoves
        extender.flatten!
        parents << extender[0] 
        extender.delete_at(0) 
        extender.each do |x|
          if eP_moves.include? x.pos
            result = findParent(x,parents)
            result << x.pos << eP           
          end  
        end 
      end
    end    
    result.each do |x|
      print x.to_s + "\n"
    end  
  end 
  
  def moves(position)
    array = []
    sub_array = []
    
    sub_array << position[0] + 1 << position[1] + 2 unless position[0] > 7 || position[1] > 6 # i
     
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] + 2 << position[1] + 1 unless position[0] > 6 || position[1] > 7 # ii 
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] + 2 << position[1] - 1 unless position[0] > 6 || position[1] < 2 # iii 
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] + 1 << position[1] - 2 unless position[0] > 7 || position[1] < 3 # iv
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] - 1 << position[1] - 2 unless position[0] < 2 || position[1] < 3 # v 
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] - 2 << position[1] - 1 unless position[0] < 3 || position[1] < 2 # vi
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] - 2 << position[1] + 1 unless position[0] < 3 || position[1] > 7 # vii
    array << sub_array unless sub_array.empty?
    sub_array = []
    sub_array << position[0] - 1 << position[1] + 2 unless position[0] < 2 || position[1] > 6 # viii
    array << sub_array unless sub_array.empty?
    sub_array = []
    count = 0
    loop do 
      node = Node.new(array[count]) 
      array.delete_at(count)
      array.unshift(node)
      break if count == array.length - 1  
      count += 1 
    end 
    array 
  end

end    

m = Algo.new 
binding.pry 
m.knight_moves([5,5],[6,2])
