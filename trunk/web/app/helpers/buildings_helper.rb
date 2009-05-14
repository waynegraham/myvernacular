module BuildingsHelper

  def setup_building(building)
    returning(building) do |b|
      b.notes.build if b.notes.empty?
    end
  end

end