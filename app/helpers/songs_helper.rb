module SongsHelper
    def artist_id_field(song)
        select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
      end
end